
class ApiResponse {
  final bool success;
  final HostsData hosts;

  ApiResponse({
    required this.success,
    required this.hosts,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      hosts: HostsData.fromJson(json['hosts']),
    );
  }
}

class HostsData {
  final List<Expert> hosts;
  final Pagination pagination;

  HostsData({
    required this.hosts,
    required this.pagination,
  });

  factory HostsData.fromJson(Map<String, dynamic> json) {
    return HostsData(
      hosts: (json['hosts'] as List).map((e) => Expert.fromJson(e)).toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Pagination {
  final int total;
  final int currentPage;
  final int totalPages;
  final int perPage;

  Pagination({
    required this.total,
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      currentPage: json['current_page'],
      totalPages: json['total_pages'],
      perPage: json['per_page'],
    );
  }
}
class Expert {
  final String id;
  final String name;
  final String? coverImage;
  final String profileImage;
  final Profession profession;
  final Profession subProfession;
  final double averageRating;
  final double minSessionPrice;
  final String aboutMe;
  final bool isVerified;
  final bool isTopCreator;
  final List<Schedule> schedule;
  final List<SocialMedia> socialMediaLinks;
  final int? sessions; // Not in API, will need to calculate
  final int? reviews; // Not in API, will need to calculate

  Expert({
    required this.id,
    required this.name,
    this.coverImage,
    required this.profileImage,
    required this.profession,
    required this.subProfession,
    required this.averageRating,
    required this.minSessionPrice,
    required this.aboutMe,
    required this.isVerified,
    required this.isTopCreator,
    required this.schedule,
    required this.socialMediaLinks,
    this.sessions,
    this.reviews,
  });

  factory Expert.fromJson(Map<String, dynamic> json) {
    return Expert(
      id: json['_id'],
      name: json['name'],
      coverImage: json['cover_image'],
      profileImage: json['profile_image'] ?? '',
      profession: Profession.fromJson(json['profession_id'] ?? {}),
      subProfession: Profession.fromJson(json['profession_sub_category_id'] ?? {}),
      averageRating: (json['average_rating'] ?? 0).toDouble(),
      minSessionPrice: (json['min_session_price'] ?? 0).toDouble(),
      aboutMe: json['about_me'] ?? '',
      isVerified: json['is_verified'] ?? false,
      isTopCreator: json['is_top_creator'] ?? false,
      schedule: (json['schedule'] as List? ?? []).map((e) => Schedule.fromJson(e)).toList(),
      socialMediaLinks: (json['social_media_links'] as List? ?? []).map((e) => SocialMedia.fromJson(e)).toList(),
      sessions: 277, // Placeholder - you might need to calculate this
      reviews: 48, // Placeholder - you might need to calculate this
    );
  }

  String get professionTitle => profession.title;
  String get subProfessionTitle => subProfession.title;
}

class Profession {
  final String id;
  final String title;
  final String description;

  Profession({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Profession.fromJson(Map<String, dynamic> json) {
    return Profession(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Schedule {
  final String weekday;
  final bool isAvailable;
  final String? availableFrom;
  final String? availableTo;

  Schedule({
    required this.weekday,
    required this.isAvailable,
    this.availableFrom,
    this.availableTo,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      weekday: json['weekday'] ?? '',
      isAvailable: json['is_available'] ?? false,
      availableFrom: json['available_from'],
      availableTo: json['available_to'],
    );
  }
}

class SocialMedia {
  final String platform;
  final String url;

  SocialMedia({
    required this.platform,
    required this.url,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      platform: json['platform'] ?? '',
      url: json['url'] ?? '',
    );
  }
}