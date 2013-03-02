class Admin::CommentsController < ApplicationController
  skip_before_filter :authorize


end
