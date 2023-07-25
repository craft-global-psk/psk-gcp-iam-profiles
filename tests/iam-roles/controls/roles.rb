title "GCP IAM Roles"

gcp_project_id = input("gcp_project_id")

describe google_project_iam_custom_role(project: gcp_project_id, name: 'DITerraformRole') do
  it { should exist }
  its('stage') { should eq 'GA' }
end

describe google_project_iam_custom_role(project: gcp_project_id, name: 'DIGkeBaseRole') do
  it { should exist }
  its('stage') { should eq 'GA' }
end

describe google_project_iam_custom_role(project: gcp_project_id, name: 'DIVpcRole') do
  it { should exist }
  its('stage') { should eq 'GA' }
end

describe google_project_iam_custom_role(project: gcp_project_id, name: 'DIPlatformGkeCoreServicesRole') do
  it { should exist }
  its('stage') { should eq 'GA' }
end

