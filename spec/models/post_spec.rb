require "rspec"

describe Post do

  let!(:post) { build :post }
  before {
    @post = post
    Post.delete_all title: @post.title
  }
  subject { @post }

  describe "Associations" do
    it { should respond_to(:author_id) }
    it { should respond_to(:content) }
    it { should respond_to(:content_display) }
    it { should respond_to(:post_time) }
    it { should respond_to(:short_url) }
    it { should respond_to(:status) }
    it { should respond_to(:title) }
    it { should respond_to(:url) }


    it { should respond_to(:tag_list) }
    it { should respond_to(:post_time_string) }
    it { should respond_to(:get_status) }


    it { should have_many(:comments) }
    it { should have_and_belong_to_many(:tags) }

  end

  describe "Validation" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:post_time) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:status) }


    #it { should validate_uniqueness_of(:url) }

  end

  describe "Scope" do
    it { described_class.should respond_to(:published) }
    it { described_class.should respond_to(:scope_tag) }
  end

  describe 'get status' do
    it { subject.should be_valid }
    its(:get_status) { should == :publish }
    it 'change status' do
      subject.status = 1
      subject.get_status.should == :draft
      subject.status = 3
      subject.get_status.should == :archive
    end
  end


  describe 'post time' do
    it 'has post_date' do
      subject.post_date.should == Time.zone.at(subject.post_time).strftime('%F')
    end

    it 'has post_time_string' do
      subject.post_time_string.should == Time.zone.at(subject.post_time).strftime('%F %T')
    end

    it 'set post_time_string' do
      now = Time.now
      subject.post_time_string = now.strftime('%F %T')
      subject.post_time.should == now.beginning_of_day.to_i
    end
  end

  describe 'convert_content' do
    it 'convert_content' do
      subject.content = '__test__'
      subject.convert_content
      subject.content_display.should == "<p><strong>test</strong></p>\n"
    end
    it 'call convert_content before save' do
      subject.content = '__test__'
      subject.save
      subject.content_display.should == "<p><strong>test</strong></p>\n"
    end
  end


  describe 'scope' do
    before do
      Post.delete_all
      @post1 = create(:post, status: 2)
      @post1.tag_list = 'tag1, tag2'
      @post2 = create(:post, status: 2)
      @post2.tag_list = 'tag2, tag3'
      @post3 = create(:post, status: 1)
      @post3.tag_list = 'tag3'
      @post4 = create(:post, status: 3)
      @post4.tag_list = 'tag5'
    end
    it 'published' do
      Post.published.should have(2).post
      Post.published.should  == [@post1, @post2]
    end

    it 'scope_tag' do
      Post.scope_tag('tag1').should == [@post1]
      Post.scope_tag('tag2').should == [@post1, @post2]
      Post.scope_tag('tag3').should == [@post2, @post3]
      Post.scope_tag('tag5').should == [@post4]
    end

    it 'combination published and scope_tag' do
      Post.published.scope_tag('tag3').should == [@post2]
    end
  end

  describe 'tags' do
    it 'add tags' do
      tags = %w{test1 test2}
      subject.tags { should be_empty}
      subject.tag_list = tags.join(', ')
      #subject.tags =
      subject.tags.should_not be_empty
      subject.tags.should have(2).tags
      subject.tags.first.name.should == 'test1'
      subject.tags.second.name.should == 'test2'
      subject.tag_array.should == tags

      subject.tag_list.should == tags.join(', ')
    end
  end
end