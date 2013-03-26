shared_examples "content_display" do |obj|
  describe 'convert_content' do
    before {
      subject.content = '__test__'
      #its { expect(subject.read_attribute(:content_display)).to be_nil }
    }
    it 'convert_content' do
      subject.convert_content
      subject.content_display.should == "<p><strong>test</strong></p>\n"
    end
    it 'call convert_content before save' do
      subject.save
      subject.content_display.should == "<p><strong>test</strong></p>\n"
    end
    it 'content_display' do
      subject.content_display.should == "<p><strong>test</strong></p>\n"
    end
  end
end