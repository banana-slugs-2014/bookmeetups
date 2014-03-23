require 'spec_helper'

describe Message do
  context "associations" do
    it { should belong_to(:meetup) }
  end
end