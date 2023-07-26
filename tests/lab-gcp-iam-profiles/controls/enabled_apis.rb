title "GCP IAM Roles"

gcp_project_id = input("gcp_project_id")

describe google_project_service(project: gcp_project_id, name: 'iamcredentials.googleapis.com') do
  it { should exist }
  its('state') { should eq 'ENABLED' }
end

describe google_project_service(project: gcp_project_id, name: 'iam.googleapis.com') do
  it { should exist }
  its('state') { should eq 'ENABLED' }
end

describe google_project_service(project: gcp_project_id, name: 'cloudresourcemanager.googleapis.com') do
  it { should exist }
  its('state') { should eq 'ENABLED' }
end

describe google_project_service(project: gcp_project_id, name: 'serviceusage.googleapis.com') do
  it { should exist }
  its('state') { should eq 'ENABLED' }
end

describe google_project_service(project: gcp_project_id, name: 'compute.googleapis.com') do
  it { should exist }
  its('state') { should eq 'ENABLED' }
end
