locals {
    common_tags = "${tomap({
        environment = "dev"
        region = "us-west-1"
        application = "acme"
    })
    }"
}
