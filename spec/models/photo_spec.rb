require 'spec_helper'

describe Photo do
  context 'associations' do
    it { should belong_to(:user) }
  end
end