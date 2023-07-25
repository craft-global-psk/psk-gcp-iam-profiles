title "GCP IAM Roles"

gcp_project_id = input("gcp_project_id")
org_id         = input("gcp_org_id")
empc_required_folders        = input("empc_required_folders")

describe.one do
  google_resourcemanager_folders(parent: "organizations/#{org_id}").names.each do |name|
    describe google_resourcemanager_folder(name: name) do 
      it { should exist }
      # TODO - Replace ['empc-core'] with imported list from our envs files
      its('display_name') { should be_in empc_required_folders }
    end
  end
end

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

