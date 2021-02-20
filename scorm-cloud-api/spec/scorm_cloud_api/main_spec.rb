require 'spec_helper'
require './lib/scorm_cloud_api/main'

RSpec.describe ScormCloudApi::Main do
  it 'hello' do
    expect(subject.hello).to eq(:hello)
  end

  it 'returns API version' do
    res = subject.about
    pp res
  end
end
