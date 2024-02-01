#------------------------------
##### variables for cloud #####
#------------------------------ 

variable "sa_key_file" {
  type        = string
  default     = "key.json"
  description = "Service account key file cloud"
}

variable "cloud_id" {
  type        = string
  description = "Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Folder ID"
}

variable "platform_id" {
  type        = string
  description = "platform_id"
}

variable "zone" {
  type        = string
  description = "zone"
}

variable "ssh_key" {
  type        = string
  description = "ssh public key"
}

#-----------------------------------
###### variables for networks ######
#-----------------------------------

variable "env_network" {
  description = "Environment subnet"
  type    = map(string)
  default = {
    vpc_name      = "vpc"
    privat_name   = "privat"
    public_name   = "public"
    ru_central1_a = "ru-central1-a"
    ru_central1_b = "ru-central1-b"
    ru_central1_c = "ru-central1-c"
  }
}