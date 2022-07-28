class EventList {
  List<Event> events;

  EventList(this.events);
}

class Event {
  int id;
  List<Performer> performers;
  Venue venue;
  String shortTitle;
  String? title;
  String dateTime;
  bool isFavourite;

  Event(this.id, this.performers, this.venue, this.shortTitle, this.title,
      this.dateTime,
      {this.isFavourite = false});
}

class Venue {
  String location;

  Venue(this.location);
}

class Performer {
  int performerId;
  String name;
  String? image;

  Performer(this.performerId, this.name, this.image);
}
