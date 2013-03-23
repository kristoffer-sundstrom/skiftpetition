class RegistrationsController < ApplicationController
  # GET /registrations
  # GET /registrations.json
  def index
    registrations = Registration.order("weight_class_id, name").all

    weight_classes = WeightClass.all(:conditions => { :id => registrations.map(&:weight_class_id) })

    @is_admin = params.fetch("admin", "false") == "kakor"

    @weight_classes = {}
    weight_classes.each do |wc|
      @weight_classes[wc.id] = wc
    end

    @seniors = registrations.select {|r| @weight_classes[r.weight_class_id].age.include?("senior") }
    @juniors = registrations.select {|r| !@weight_classes[r.weight_class_id].age.include?("senior")}

    respond_to do |format|
      format.html # index.html.erb
      format.json {
        render json: registrations.map { |r|
            h = r.attributes
            h[:weight_class] = @weight_classes.fetch(r.weight_class_id, r.weight_class_id)
            h
        }
      }
      format.txt {
        render :text => registrations.map { |r|
                  wc = @weight_classes.fetch(r.weight_class_id, r.weight_class_id)
                  [r[:name], r[:club], wc[:weight], r[:name], r[:name], rand(1000), rand(1000), "M", ""].join(";")
        }.join("\n")

      }

      format.csv {

        # format:
        # member nr, club idnr, clubname, club short, first name, suffix, last name, genus(M/F), date of birth (dd-mm),
        # year of birth (yyyy), function (competitor), event nr, weight cat, address, zip code, city, phone, kyu

        send_data registrations.map { |r|
                          wc = @weight_classes.fetch(r.weight_class_id, r.weight_class_id)
                          [r[:name], r[:club], wc[:weight], r[:name], r[:name], rand(1000), rand(1000), "M", ""]
                }.to_csv
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
    @action = "new"
    @registration = Registration.new
    @weight_classes = WeightClass.order("age, gender, beginner_elite, weight").all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @action = "edit"
    @registration = Registration.find(params[:id])
    @weight_classes = WeightClass.order("age, gender, beginner_elite, weight").all
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

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
        format.html { redirect_to registrations_path, notice: 'Registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
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
