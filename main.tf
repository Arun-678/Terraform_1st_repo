# policy: enforce-env-prod.sentinel
# Purpose: Ensure every resource created by Terraform has the tag Env=prod

import "tfplan"
import "strings"

# === Function: Check Tags ===
# Returns true if resource has Env tag set to "prod"
validate_tags = func(resource) {
  # Some resources may not support tags, so check existence first
  if resource.applied.tags is null {
    return false
  }

  # Normalize to lowercase to avoid case mismatches
  value = strings.lower(resource.applied.tags["Env"])
  return value == "prod"
}

# === Main Rule ===
main = rule {
  all tfplan.resources as type, instances {
    all instances as name, res {
      validate_tags(res)
    }
  }
}
