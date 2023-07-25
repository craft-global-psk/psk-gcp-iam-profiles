data "tfe_organization" "twdps" {
  name = "twdps"
}

resource "tfe_workspace" "workspace" {
  count          = length(var.workspace_environments)
  organization   = data.tfe_organization.twdps.name
  name           = format("%s-%s", var.workspace_prefix, var.workspace_environments[count.index])
  tag_names      = [var.workspace_prefix]
  execution_mode = "local"
  description    = format("State storage for CUR deployment of the cohort-base deployment in %s", var.workspace_environments[count.index])
}
