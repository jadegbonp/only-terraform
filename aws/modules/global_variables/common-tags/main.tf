locals {
    common_tags = "${map(
        "environment", "dev",
        "region", "us-west-1",
        "application", "acme",
    )}"
}