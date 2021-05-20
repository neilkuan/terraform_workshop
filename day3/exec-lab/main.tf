resource "null_resource" "make-file" {
  provisioner "local-exec" {
    command = "echo '0' > test-file.txt"
  }
  
  // so we set the staus to remove or add another value in the test-file.txt
  provisioner "local-exec" {
    when = destroy
    command = "rm -f test-file.txt"
  }
}