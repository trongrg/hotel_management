def wait_for(value, wait_time = nil)
  wait_time ||= Capybara.default_wait_time
  res = nil
  begin
    res = yield
    wait_time -= 0.5
    sleep 0.5 unless res == value
  end while (wait_time >=0 && res != value)
  res.should == value
end
