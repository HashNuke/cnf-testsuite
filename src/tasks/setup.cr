require "sam"
require "file_utils"
require "colorize"
require "totem"

desc "Sets up the CNF test suite, the K8s cluster, and upstream projects"
task "setup", [ "offline", "helm_local_install", "prereqs", "configuration_file_setup", "install_opa" , "install_api_snoop", "install_sonobuoy", "install_chart_testing", "cnf_conformance_setup"] do  |_, args|

  stdout_success "Setup complete"
end

task "offline" do |_, args|
  #./cnf-testsuite setup --offline=./airgapped.tar.gz
  output_file = args.named["offline"].as(String) if args.named["offline"]?
  if output_file && !output_file.empty?
      AirGap.extract(output_file)
  end
end

task "configuration_file_setup" do |_, args|
  VERBOSE_LOGGING.info "configuration_file_setup" if check_verbose(args)
  CNFManager::Points.create_points_yml
end

