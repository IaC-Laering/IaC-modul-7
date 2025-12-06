variable "rgname" {
  description = "Navn på Resource Group"
  type        = string
  default = "rg-paupr-A-10"
}

variable "location" {
  description = "Azure region hvor ressursene skal opprettes"
  type        = string
  default     = "norwayeast"
}

variable "saname" {
  description = "Navn på Storage Account"
  type        = string
  default = "sapaupr10"
}