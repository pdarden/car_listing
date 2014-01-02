require 'spec_helper'

describe Car do
  let(:blanks) { ['', nil] }

  it { should have_valid(:color).when('red') }
  it { should_not have_valid(:color).when(*blanks) }

  it { should have_valid(:description).when(*blanks) }

  it { should validate_numericality_of(:year).only_integer }
  it { should validate_numericality_of(:year).is_greater_than_or_equal_to(1980) }

  it { should validate_numericality_of(:mileage).only_integer }
  it { should validate_numericality_of(:mileage).is_greater_than_or_equal_to(0) }

end
