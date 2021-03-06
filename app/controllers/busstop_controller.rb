class BusstopController < ApplicationController
    before_filter :authenticate_admin!
    before_filter :authenticate_isAdmin#, :except => [:showAll, :view]
    #before_filter :authenticate_company, :only => [:showAll, :view], unless: :current_user_isAdmin?
    
    def index  
    end

    def showAll
        @busstops = Busstop.all
        #Debugging Purpose Only. Remove Immediatley.
        # path = BusstopNode.findRoute(1, 42)
        # @pathRoute = path.collect(&:busstop)
        # flash[:alert] = @pathRoute.collect(&:busStopName)
    end

    def view
        @busstop = Busstop.find(params[:id])
    end

    def new
        @busstop = Busstop.new
    end

    def createBusstop
        @busstop = Busstop.new(busstop_params)
        @busstop.admin_id = current_admin.id
        fieldParams = Hash.new
        fieldParams = {:busStopLatLong => @busstop.busStopLatLong}
        @busstop.valid?
        resultHash = Hash.new
        errorResult = @busstop.validateLatLong(fieldParams)
        errorResult.each do |key, value|
            @busstop.errors.add(key, 'Improper \'LatLong\' format')
        end
        if (@busstop.errors.blank?)
            @busstop.save
            redirect_to busstop_showAll_path
        else
            render 'new'
        end        
    end
 
    def showEdit
        @editBusstop = Busstop.find(params[:id])
    end

    def update
        @editBusstop = Busstop.find(params[:id])
        begin
            @editBusstop.update_attributes!(params.require(:busstop).permit(:busStopName, :busStopLatLong, :busStopSecName))
            redirect_to busstop_view_path(@editBusstop.id)
        rescue => e
            flash[:alert] = "#{e}. Please fill the form correctly"
            redirect_to :back and return
        ensure
            
        end
    end

    def destroy
        begin
            @busstops = Busstop.find(params[:id])
            @busstops.destroy
            flash[:notice] = "Bus stop: \'#{@busstops.busStopName}\' deleted."
        rescue ActiveRecord::DeleteRestrictionError => e
            flash[:alert] = "Action Restricted. Please remove this busstop from every route it appears in, then try again."
        ensure
            redirect_to busstop_showAll_path
        end
    end
    #Private Members for Busstop  
    private
    
    def busstop_params
        params.require(:busstop).permit(:busStopName, :busStopLatLong, :busStopSecName)
    end
    
    

end
