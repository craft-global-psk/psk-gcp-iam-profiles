title "GCP IAM Roles"

gcp_project_id = input("gcp_project_id")

describe google_project_iam_custom_role(project: gcp_project_id, name: 'EMPCTerraformBaseRole') do
  it { should exist }
  its('stage') { should eq 'GA' }
end

describe google_project_iam_custom_role(project: gcp_project_id, name: 'EMPCIAMProfilesRole') do
  it { should exist }
  its('stage') { should eq 'GA' }
end

describe google_project_iam_custom_role(project: gcp_project_id, name: 'EMPCVPCRole') do
  it { should exist }
  its('stage') { should eq 'GA' }
end
