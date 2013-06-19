require 'spec_helper'

describe Post do

  let!(:post) { build :post }
  before {
    @post = post
    Post.delete_all title: @post.title
  }
  subject { @post }

  describe "Associations" do
    it { should respond_to(:user_id) }
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
    # todo: fix test
    #xit { should have_and_belong_to_many(:tags) }
    #join_table(:posts_tags)

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
    it { expect(subject).to be_valid }
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

  it_should_behave_like 'content_display'



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
      Post.published.should =~ [@post1, @post2]
    end

    it 'scope_tag' do
      Post.scope_tag('tag1').should have(1).post
      Post.scope_tag('tag1').should =~ [@post1]
      Post.scope_tag('tag2').should have(2).post
      Post.scope_tag('tag2').should =~ [@post1, @post2]
      Post.scope_tag('tag3').should have(2).post
      Post.scope_tag('tag3').should =~ [@post2, @post3]
      Post.scope_tag('tag5').should have(1).post
      Post.scope_tag('tag5').should =~ [@post4]
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
      subject.tags.should have(2).items
      subject.tags.first.name.should == 'test1'
      subject.tags.second.name.should == 'test2'
      subject.tag_array.should == tags

      subject.tag_list.should == tags.join(', ')
    end
  end

  describe 'attachment' do
    it 'remove empty assets' do
      5.times { subject.assets.build }
      subject.save
      expect(subject.assets.size).to eq 0
    end
  end

  describe 'search' do

    before do
      Post.delete_all
      @time = Time.now.to_i
      @post1 = create(:post, status: 2, content: 'stamm hello', post_time: @time - 2)
      @post2 = create(:post, status: 2, content: 'stamm goodbye', post_time: @time)
      @post3 = create(:post, status: 2, content: 'stalin hello', post_time: @time + 2)
    end

    context 'search by content' do
      it do
        result = Post.search('hello')
        expect(result).to have(2).items
        expect(result).to eq [@post3.id, @post1.id]
      end

      it do
        result = Post.search('stalin')
        expect(result).to have(1).items
        expect(result).to eq [@post3.id]
      end

      it do
        result = Post.search('goodbye')
        expect(result).to have(1).items
        expect(result).to eq [@post2.id]
      end
    end

    context 'search by title' do
      before do
        @post4 = create(:post, status: 2, content: 'stamm goodbye', title: 'hello title', post_time: @time-3)
      end
      it do
        result = Post.search('hello')
        expect(result).to have(3).items
        expect(result).to eq [@post3.id, @post1.id, @post4.id]
      end

      it do
        result = Post.search('title')
        expect(result).to have(1).items
        expect(result).to eq [@post4.id]
      end
    end

    context 'scope' do
      it do
        result = Post.scope_ordered_ids([@post1.id, @post3.id, @post2.id])
        expect(result).to eq [@post1, @post3, @post2]
      end
    end
  end

end