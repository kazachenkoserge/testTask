global class SchedulableBatch implements Schedulable {
    public SchedulableBatch() {

    }
    global void execute(SchedulableContext sc){
        CaseBatch batch = new CaseBatch();
        Database.executeBatch(batch);
    }
}
