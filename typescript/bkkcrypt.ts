class BKKCrypt {
    password: string;
    constructor(password: string) {
        this.password = password;
    }
    crypt() {
        return this.password;
    }
}


let bkk = new BKKCrypt("jelszoka");
console.log(bkk.crypt());
