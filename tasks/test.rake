$stdout.sync = true
$stderr.sync = true

desc "Execute unit tests"
task :tests do
  exit_code = 0

  def launch(device)
    device.settings.disable_keyboard_helpers!

    device.launch!
    device.wait! {|d| File.exists?(d.path.device_plist)}
    device.wait! {|d| d.state == :booted}
  end

  # Get path for local copy of xctool
  xctool_path = File.join(Dir.pwd, "tasks", "bin", "xctool", "0.2.9", "bin", "xctool")

  # Build the common part of the command
  base_command = "#{xctool_path} -derivedDataPath '#{File.join(Dir.pwd, 'build')}' -scheme 'EBKSampleApp' -sdk iphonesimulator -project EBKSampleApp.xcodeproj"


  # Create an array of Simulators
  devices = [
    SimCtl.reset_device('SampleApp iPhone 5', SimCtl.devicetype(name: 'iPhone 5'),    SimCtl::Runtime.latest(:ios)),
    SimCtl.reset_device('SampleApp iPhone 6', SimCtl.devicetype(name: 'iPhone 6'),    SimCtl::Runtime.latest(:ios)),
    # SimCtl.reset_device('SampleApp iPad',   SimCtl.devicetype(name: 'iPad Retina'), SimCtl::Runtime.latest(:ios)),
  ]

  # Run one by one
  devices.each {|device| launch(device)}

  # Build tests once
  sh "#{base_command} build-tests"


  threads = []

  # Run tests on each device in a separate thread
  devices.each do |device|
    threads << Thread.new do

      sh "#{base_command} run-tests -destination 'id=#{device.udid}'"

      Thread.current[:result] = $?
      device.kill!
      device.wait! {|d| d.state == :shutdown}
    end
  end

  # Wait for all threads to finish
  threads.each do |thread|
    thread.join
    exit_code |= thread[:result].to_i
  end

  exit exit_code
end

