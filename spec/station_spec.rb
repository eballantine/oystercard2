require 'station'
describe Station do
  let(:subject) { described_class.new("Kings Cross", 1) }

	describe '#initialize' do
		it {is_expected.to have_attributes(:name => "Kings Cross", :zone => 1) }
	end
end