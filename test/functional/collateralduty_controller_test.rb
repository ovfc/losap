require 'test_helper'

class CollateraldutysControllerTest < ActionController::TestCase
  
  def setup
    @m1 = members(:one)
    @m2 = members(:two)
    @one = collateraldutys(:one)
    @two = collateraldutys(:two)
  end

  test 'index' do
    get :index, :member_id => @m1.id, :format => "xml"
    assert_response :success
    
    @one.member = @m1
    assert @one.save, @one.errors.inspect
    @two.member = @m1
    @two.start_time = @one.start_time + 1.day
    @two.end_time = @one.end_time + 1.day
    assert @two.save, @two.errors.inspect
    get :index, :member_id => @m1.id, :format => "xml"
    assert_response :success

    s = Collateralduty.new
    s.start_time = @one.start_time - 5.days
    s.end_time = @one.end_time - 5.days
    s.member = @m1
    assert s.save
    get :index, :member_id => @m1.id, :format => "xml"
    assert_response :success
  end

  test 'new' do
    get :new, :member_id => @m1.id
    assert_response :success
    assert_template('collateraldutys/new')
  end

  test 'create valid' do
    post :create, :collateralduty => {:start_time => @one.start_time,
      :end_time => @one.end_time},
    :member_id => @m1.id
    assert_redirected_to(@m1)
    assert_equal('Saved Collateralduty', flash[:notice])
  end
  
  test 'crate invalid' do
    post :create, :collateralduty => {:end_time => @one.start_time + 1.day},
                  :member_id => @m1.id
    assert_response :success
    assert_template('collateraldutys/new')

    post :create, :collateralduty => {:start_time => Date.parse('2010-5-10') + 7.hours,
        :end_time => Date.parse('2010-5-10') + 15.hours},
        :member_id => @m1.id
    assert_response :success
    assert_template('collateraldutys/new')    
  end                        

  test 'destroy' do
    assert_raise(ActiveRecord::RecordNotFound) {post :destroy, :id => 7, :member_id => @m1.id}

    @m1.collateraldutys << @one
    s = Collateralduty.new(:start_time => @one.start_time + 1.day,
                    :end_time => @one.end_time + 1.day)
    @m1.collateraldutys << s
    collateralduty_count = Collateralduty.count
    assert_equal(2, @m1.collateraldutys.count)

    post :destroy, :id => s.id, :member_id => @m1.id
    assert_redirected_to(@m1)
    assert_equal(1, @m1.collateraldutys.count)
    assert_equal(collateralduty_count - 1, Collateralduty.count)
  end
end
