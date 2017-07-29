#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/device.h>
#include <linux/init.h>
#include <linux/fs.h>
#include <linux/uaccess.h>
#include <linux/string.h>
#include <linux/sched.h>
#include <linux/mutex.h>
#include <linux/slab.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR( "vista <vista@national.shitposting.agency>");
MODULE_DESCRIPTION("A kernel module that provides the BKKCrypt algorithm as a character device. MT-Safe implementation");
MODULE_VERSION("1.0");

#define DEVICE_NAME "bkkcrypt"
#define CLASS_NAME "bkkcrypt"
#define BUFSIZE 255

/*
 * We will implement these four basic file system operations: reading, writing, opening/closing a file.
 */

static ssize_t bkkcrypt_read(struct file*, char*, size_t, loff_t*);
static ssize_t bkkcrypt_write(struct file*, const char*, size_t, loff_t*);
static int bkkcrypt_open(struct inode*, struct file*);
static int bkkcrypt_release(struct inode*, struct file*);

/*
 * The major number of our device.
 */
static int major;

/*
 * The device class that will be assigned to our device. Normally, a simple character device like this would
 * be considered a "miscellaneous" character device and not given a unique minor number, but I consider the
 * BKKCrypt crypto character device is so important, I think should have a unique one.
 */
static struct class* bkk_class = NULL;

/*
 * The device itself.
 */
static struct device* bkk_dev = NULL;

/*
 * We assign the file operations to the function pointers of our own character device.
 * This is the reason why we need to declare those functions beforehand.
 */
static struct file_operations file_ops = {
        .read = bkkcrypt_read,
        .write = bkkcrypt_write,
        .open = bkkcrypt_open,
        .release = bkkcrypt_release
};

/*
 * The buffer struct for storing the ciphertext.
 * Contains a wait queue to allow for reading before writing, and a mutex lock to control parallel access.
 */
struct buf {
        char* data;
        char* mid_ptr;
        char* end;
        unsigned long size;
        wait_queue_head_t read_queue;
        struct mutex lock;
};

/*
 * The ciphertext is stored in a common buffer.
 */
struct buf* ciphertext_buf;

/*
 * Buffer allocation happens here.
 */
static struct buf* buf_alloc(unsigned long size) {
        struct buf* _buf;
        _buf = kzalloc(sizeof(struct buf), GFP_KERNEL);
        if(unlikely(!_buf)) {
          return NULL;
        }

        _buf->data = kzalloc(size, GFP_KERNEL);
        if(unlikely(!_buf->data)) {
          kfree(_buf);
          return NULL;
        }

        _buf->size = size;
        init_waitqueue_head(&_buf->read_queue);
        mutex_init(&_buf->lock);

        return _buf;
}

/*
 * Buffer free routine. Self-explanatory.
 */
static void buf_free(struct buf* buf) {
        kfree(buf->data);
        kfree(buf);
}

/*
 * This function is the entry point of the kernel module.
 * We initialize the major number, class and create the actual character device.
 * Allocation for the ciphertext buffer is done on init as well.
 */
static int __init init_mod(void) {
        printk(KERN_INFO "bkkcrypt: Initializing BKKCrypt module...\n");

        major = register_chrdev(0, DEVICE_NAME, &file_ops);
        if(major < 0) {
                printk(KERN_ALERT "bkkcrypt: Registering BKKCrypt dev major number failed: %d\n", major);
                return major;
        }

        bkk_class = class_create(THIS_MODULE, CLASS_NAME);
        if(IS_ERR(bkk_class)) {
                unregister_chrdev(major, DEVICE_NAME);
                printk(KERN_ALERT "bkkcrypt: Error registering dev class\n");
                return PTR_ERR(bkk_class);
        }

        bkk_dev = device_create(bkk_class, NULL, MKDEV(major, 0), NULL, DEVICE_NAME);
        if(IS_ERR(bkk_dev)) {
                class_unregister(bkk_class);
                class_destroy(bkk_class);
                unregister_chrdev(major, DEVICE_NAME);
                printk(KERN_ALERT "bkkcrypt: Error registering char device\n");
                return PTR_ERR(bkk_class);
        }

        ciphertext_buf = buf_alloc(BUFSIZE);

        printk(KERN_INFO "bkkcrypt: BKKCrypt device initialized.\n");
        return 0;
}

/*
 * The exit point of the kernel module, called upon removal of kernel module or shutdown.
 * Unregisters the device, class and major number.
 * The common ciphertext buffer is free'd in this routine.
 */
static void __exit clean_mod(void) {
        buf_free(ciphertext_buf);
        device_destroy(bkk_class, MKDEV(major, 0));
        class_unregister(bkk_class);
        class_destroy(bkk_class);
        unregister_chrdev(major, DEVICE_NAME);
        printk(KERN_INFO "bkkcrypt: BKKCrypt module unloaded\n");
}

/*
 * Device open.
 */
static int bkkcrypt_open(struct inode* inode_ptr, struct file* file_ptr) {

 	return 0;
}


/*
 * Device close.
 */
static int bkkcrypt_release(struct inode* inode_ptr, struct file* file_ptr) {

        return 0;
}

/*
 * Called when a write occurs to the device.
 * This function also implements the BKKCrypt encryption algorithm.
 */
static ssize_t bkkcrypt_write(struct file* file_ptr, const char* out_buf, size_t len, loff_t* offset) {
        struct buf* buf = ciphertext_buf;
        ssize_t err = 0;

        /*
         * If the input data is too large, don't handle it.
         */
        if(len > BUFSIZE) {
                printk(KERN_INFO "bkkcrypt: This BKKCrypt device only supports messages up to 255 characters long. For longer message support, please insert more money.\n");
                err = -EFBIG;
                return err;
        }

        /*
         * Attempt to get a lock on the common ciphertext buffer.
         */
        if(mutex_lock_interruptible(&buf->lock)) {
                err = -ERESTARTSYS;
                return err;
        }

        /*
         * Zero out the ciphertext buffer and attempt to insert the input into it.
         * The BKKCrypt encryption algorithm is transparently applied upon insertion.
         */
        memset(buf->data, 0, buf->size);
        err = copy_from_user(buf->data, out_buf, len);
        if(err) {
               	printk(KERN_ALERT "bkkcrypt: Failed to read %ld chars", err);
                mutex_unlock(&buf->lock);
                return -EFAULT;
       	}

        /*
         * Bookkeeping...
         */
        buf->end = buf->data + len;
        buf->mid_ptr = buf->data;

        /*
         * Let go of the mutex, signal the wait queue in case someone wants to read the ciphertext buffer.
         */
        mutex_unlock(&buf->lock);
        wake_up_interruptible(&buf->read_queue);

        return len;
}

/*
 * Called when something tries to read the device.
 */
static ssize_t bkkcrypt_read(struct file* file_ptr, char* out_buf, size_t len, loff_t* offset) {
        struct buf* buf = ciphertext_buf;
        ssize_t err;

        /*
         * Attempt to get a lock...
         */
        if(mutex_lock_interruptible(&buf->lock)) {
                err = -ERESTARTSYS;
                return err;
        }

        /*
         * If there is nothing new to read, just let go of the mutex and wait.
         */
        while (buf->mid_ptr == buf->end) {
                mutex_unlock(&buf->lock);
                if (file_ptr->f_flags & O_NONBLOCK) {
                        err = -EAGAIN;
                        return err;
                }
                if (wait_event_interruptible(buf->read_queue, buf->mid_ptr != buf->end)) {
                        err = -ERESTARTSYS;
                        return err;
                }
                if(mutex_lock_interruptible(&buf->lock)) {
                        err = -ERESTARTSYS;
                        return err;
                }

        }

        /*
         * In case someone did something nasty, we should only print the maximum size of the buffer (1024)
         */
        err = min(buf->size, (size_t) (buf->data - buf->end));
        if ((err = copy_to_user(out_buf, buf->data, err))) {
                printk("bkkcrypt: Failed to write %ld chars", err);
                err = -EFAULT;
                mutex_unlock(&buf->lock);
                return err;
        }
        buf->mid_ptr += err;

        /*
         * Let it goooo!
         */
        mutex_unlock(&buf->lock);

        return err;
}

module_init(init_mod);
module_exit(clean_mod);
