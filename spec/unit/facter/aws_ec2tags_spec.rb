# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/aws_ec2tags'

describe :aws_ec2tags, type: :fact do
  subject(:fact) { Facter.fact(:aws_ec2tags) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
  end

  it 'returns a value' do
    expect(fact.value).to eq('hello facter')
  end
end
