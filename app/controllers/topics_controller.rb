class TopicsController < ApplicationController
  before_action :set_topic, only: %I[show update destroy]
  before_action :set_forum, only: %I[index create]

  # GET /topics
  def index
    @topics = if @forum
                @forum.topics
              else
                Topic.all
              end

    render json: @topics
  end

  # GET /topics/1
  def show
    render json: @topic
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      render json: @topic, status: :created, location: @topic
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /topics/1
  def update
    if @topic.update(topic_params)
      render json: @topic
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # DELETE /topics/1
  def destroy
    @topic.destroy
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def set_forum
    @forum = Forum.find(params[:forum_id]) if params[:forum_id]
  end

  def topic_params
    params.require(:topic).permit(:forum_id, :title, :user_id)
  end
end
