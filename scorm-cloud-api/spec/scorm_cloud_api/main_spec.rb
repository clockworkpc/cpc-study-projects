require 'spec_helper'
require './lib/scorm_cloud_api/main'

RSpec.describe ScormCloudApi::Main do
  let(:course_config_json) do
    path = './spec/fixtures/course_configuration.json'
    JSON.parse(File.read(path), { symbolize_names: true })
  end

  it 'returns API version' do
    res = subject.about
    expect(res.distribution).to eq('SCORM Cloud')
    expect(res.version).to eq('Api V2')
  end

  it 'returns all courses' do
    res = subject.courses
    ref_test = res.courses.first
    expect(ref_test.activity_id).to eq(ENV['SCORM_CLOUD_USERNAME'])
    expect(ref_test.course_learning_standard).to eq('SCORM12')
    expect(ref_test.id).to eq('reference_test')
  end

  it 'returns reference_test course details' do
    res = subject.course(id: 'reference_test')
    expect(res.activity_id).to eq(ENV['SCORM_CLOUD_USERNAME'])
    expect(res.course_learning_standard).to eq('SCORM12')
    expect(res.id).to eq('reference_test')
  end

  it 'returns reference_test course configuration' do
    res = subject.course_configuration(id: 'reference_test')
    expect(res.to_hash).to eq(course_config_json)
  end
end
