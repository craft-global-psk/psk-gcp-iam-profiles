title "GCP IAM Roles"

gcp_project_id = input("gcp_project_id")

describe google_project_iam_custom_role(project: gcp_project_id, name: 'PSKTerraformBaseRole') do
  it { should exist }
  its('stage') { should eq 'GA' }
end

describe google_project_iam_custom_role(project: gcp_project_id, name: 'PSKIAMProfilesRole') do
  it { should exist }
  its('stage') { should eq 'GA' }
end

describe google_project_iam_custom_role(project: gcp_project_id, name: 'PSKVPCRole') do
  it { should exist }
  its('stage') { should eq 'GA' }
end
