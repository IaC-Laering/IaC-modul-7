variable "rgname" {
  description = "Navn på Resource Group"
  type        = string
  default = "rg-paupr-B-10"
}

variable "location" {
  description = "Azure region hvor ressursene skal opprettes"
  type        = string
  default     = "norwayeast"
}