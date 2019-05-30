require 'rails_helper'

describe Message do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :vacation }
  end
end
