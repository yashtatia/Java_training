package FlightPackage;

public class Flight{
	// flt_route table
	String source_id;
	String destination_id;
	int miles;

	//flt_flight table
	private int flight_id;
	private String carrier_id;
	private String flight_type;
	private int route_id;
	private String flight_date;
	private String flight_time;
	private int vacancy_eco;
	private int vacancy_bus;
	private int vacancy_elt;
	private int price_eco;
	private int price_bus;
	private int price_elt;

	Flight(String source_id, String destination_id, int miles, int flight_id, String carrier_id, String flight_type, int route_id, String flight_date, String flight_time, int vacancy_eco, int vacancy_bus, int vacancy_elt, int price_eco, int price_bus, int price_elt){
		this.source_id = source_id;
		this.destination_id = destination_id;
		this.miles = miles;
		this.flight_id = flight_id;
		this.carrier_id = carrier_id;
		this.flight_type = flight_type;
		this.route_id = route_id;
		this.flight_date = flight_date;
		this.flight_time = flight_time;
		this.vacancy_eco = vacancy_eco;
		this.vacancy_bus = vacancy_bus;
		this.vacancy_elt = vacancy_elt;
		this.price_eco = price_eco;
		this.price_bus = price_bus;
		this.price_elt = price_elt;
	}

	public String getSource_id() {
        return source_id;
    }

    public String getDestination_id() {
        return destination_id;
    }

    public int getMiles() {
        return miles;
    }

    public int getFlight_id() {
        return flight_id;
    }

    public String getCarrier_id() {
        return carrier_id;
    }

    public String getFlight_type() {
        return flight_type;
    }

    public int getRoute_id() {
        return route_id;
    }

    public String getFlight_date() {
        return flight_date;
    }

    public String getFlight_time() {
        return flight_time;
    }

    public int getVacancy_eco() {
        return vacancy_eco;
    }

    public int getVacancy_bus() {
        return vacancy_bus;
    }

    public int getVacancy_elt() {
        return vacancy_elt;
    }

    public int getPrice_eco() {
        return price_eco;
    }

    public int getPrice_bus() {
        return price_bus;
    }

    public int getPrice_elt() {
        return price_elt;
    }
}
