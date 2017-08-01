use <bkkcrypt.scad>

if (bkkcrypt("password") == "password") {
   echo("Test passed.");
} else {
   echo("Test failed.");
}
