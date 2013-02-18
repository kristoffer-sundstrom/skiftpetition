class RegistrationsController < ApplicationController
  # GET /registrations
  # GET /registrations.json
  def index
    registrations = Registration.order("weight_class_id, name").all

    weight_classes = WeightClass.all(:conditions => { :id => registrations.map(&:weight_class_id) })

    @weight_classes = {}
    weight_classes.each do |wc|
      @weight_classes[wc.id] = wc
    end

    @seniors = registrations.select {|r| @weight_classes[r.weight_class_id].age == "senior"}
    @juniors = registrations.select {|r| @weight_classes[r.weight_class_id].age != "senior"}

    respond_to do |format|
      format.html # index.html.erb
      format.json {
        render json: registrations.map { |r|
            h = r.attributes
            h[:weight_class] = @weight_classes.fetch(r.weight_class_id, r.weight_class_id)
            h
        }
      }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    @registration = Registration.new
    @weight_classes = WeightClass.order("age, gender, weight").all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(params[:registration])
    @weight_classes = WeightClass.order("age, gender, weight").all

    respond_to do |format|
      if @registration.save
        format.html { redirect_to registrations_path, notice: 'Registration was successfully created.' }
        format.json { render json: @registration, status: :created, location: @registration }
      else
        format.html { render action: "new" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /registrations/1
  # PUT /registrations/1.json
  def update
    @registration = Registration.find(params[:id])

    if @registration.email == params[:email]

      respond_to do |format|
        if @registration.update_attributes(params[:registration])
          format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @registration.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration = Registration.find(params[:id])


    if @registration.email == params[:email]
      @registration.destroy
    end

    respond_to do |format|
      format.html { redirect_to registrations_url }
      format.json { head :no_content }
    end
  end
end
