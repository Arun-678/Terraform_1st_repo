import "tfplan/v2" as tfplan

# Function to check tags
validate_tags = func(resource) {
    # Some resources may not support tags
    if not ("tags" in resource.applied) {
        return true
    }

    # Check if "Env" tag exists and equals "Prod"
    return resource.applied.tags["Env"] is "Prod"
}

# Collect all resources from the plan
resources = filter tfplan.resource_changes as _, rc {
    rc.mode is "managed" and rc.type is not null
}

# Run validation
all_tags_valid = all resources as _, rc {
    validate_tags(rc)
}

# Main Rule
main = rule {
    all_tags_valid
}
