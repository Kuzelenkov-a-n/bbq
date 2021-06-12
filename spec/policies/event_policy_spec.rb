require 'rails_helper'

RSpec.describe EventPolicy do
  subject { described_class }

  let(:user) { create(:user) }

  let(:event_without_pin) { create(:event, user: user) }
  let(:event_with_pin) { create(:event, user: user, pincode: '1234') }

  let(:valid_cookies) { { "events_#{event_with_pin.id}_pincode" => '1234' } }

  let(:event_owner) { OpenStruct.new(user: user, cookies: {}) }
  let(:anon_with_valid_cookies) { OpenStruct.new(user: nil, cookies: valid_cookies) }
  let(:anon_without_valid_cookies) { OpenStruct.new(user: nil, cookies: {}) }
  let(:other_user) { OpenStruct.new(user: create(:user), cookies: {}) }

  describe '#edit?, update?, destroy?' do
    context 'when user is owner' do
      permissions :edit?, :update?, :destroy? do
        it { is_expected.to permit(event_owner, event_without_pin) }
      end
    end

    context 'when user is not owner' do
      permissions :edit?, :update?, :destroy? do
        it { is_expected.not_to permit(other_user, event_without_pin) }
      end
    end

    context 'when user is anonymous' do
      permissions :edit?, :update?, :destroy? do
        it { is_expected.not_to permit(anon_without_valid_cookies, event_without_pin) }
      end
    end
  end

  describe '#show?' do
    context 'when pincode is present' do
      context 'and user is owner' do
        permissions :show? do
          it { is_expected.to permit(event_owner, event_with_pin) }
        end
      end

      context 'and anonymous has valid cookies' do
        permissions :show? do
          it { is_expected.to permit(anon_with_valid_cookies, event_with_pin) }
        end
      end

      context 'and anonymous has not valid cookies' do
        permissions :show? do
          it { is_expected.not_to permit(anon_without_valid_cookies, event_with_pin) }
        end
      end
    end

    context 'when pincode is blank' do
      permissions :show? do
        it { is_expected.to permit(anon_without_valid_cookies, event_without_pin) }
      end
    end
  end
end
