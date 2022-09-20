variable "s3_folders" {
  type        = list
  description = "The list of S3 folders to create"
  default     = ["image","logs"]
}
