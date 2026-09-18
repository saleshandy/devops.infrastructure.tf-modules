variable "zone_id" {
  type        = string
  description = "Cloudflare zone the record belongs to"
}

variable "name" {
  type        = string
  description = "Full record name, e.g. app.example.com (no trailing dot)"
}

variable "type" {
  type        = string
  description = "Record type: A, AAAA, CNAME, TXT, MX, ..."
}

variable "content" {
  type        = string
  description = "Record value, e.g. an IP, hostname or TXT string (no trailing dot)"
}

variable "ttl" {
  type        = number
  description = "TTL in seconds; 1 means automatic. Must be 1 when the record is proxied"
  default     = 1
}

variable "proxied" {
  type        = bool
  description = "Route the record through Cloudflare's proxy. Must be false for validation and non-HTTP records"
  default     = false
}

variable "comment" {
  type        = string
  description = "Comment shown in the Cloudflare dashboard"
  default     = null
}
