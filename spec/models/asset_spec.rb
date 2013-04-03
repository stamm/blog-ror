require 'spec_helper'

describe Asset do
  describe 'attached file' do
    it { should have_attached_file(:image) }
    it { should validate_attachment_presence(:image) }
    it { should validate_attachment_content_type(:image).
                    allowing('image/png', 'image/gif').
                    rejecting('text/plain', 'text/xml') }
    it { should validate_attachment_size(:image).
                    less_than(10.megabytes) }
  end

  describe '#to_i' do
    before do
      @asset = build :asset
      @asset.save
    end
    it { expect(@asset.to_i).to eq @asset.id }
  end
end
