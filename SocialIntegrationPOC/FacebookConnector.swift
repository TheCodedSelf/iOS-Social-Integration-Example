//
//  FacebookConnector.swift
//  SocialIntegrationPOC
//
//  Created by Keegan Rush on 2016/12/26.
//  Copyright © 2016 Shnapped. All rights reserved.
//

import Foundation
import FBSDKLoginKit


struct FacebookConnector {
    
    private static let selectedUserProperties = ["id", "about", "age_range", "birthday", "context", "cover", "currency", "devices", "education", "email", "first_name", "gender", "hometown", "install_type", "installed", "interested_in", "is_shared_login", "is_verified", "languages", "last_name", "link", "locale", "location", "middle_name", "name", "name_format", "payment_pricepoints.limit(5)", "political", "public_key", "relationship_status", "religion", "security_settings", "significant_other", "timezone", "updated_time", "verified", "website", "work", "accounts.limit(5)", "ad_studies", "adaccounts.limit(5)", "adcontracts.limit(5)", "adnetworkanalytics.limit(5)", "domains", "events.limit(5)", "family.limit(5)", "friendlists.limit(5)", "friends.limit(5)" ,"permissions.limit(5)", "personal_ad_accounts.limit(5)", "picture", "request_history", "session_keys.limit(5)", "scores.limit(5)"]
    
    private static let allUserProperties = ["id", "about", "admin_notes", "age_range", "birthday", "context", "cover", "currency", "devices", "education", "email", "employee_number", "favorite_athletes", "favorite_teams", "first_name", "gender", "hometown", "inspirational_people", "install_type", "installed", "interested_in", "is_shared_login", "is_verified", "labels", "languages", "last_name", "link", "locale", "location", "meeting_for", "middle_name", "name", "name_format", "payment_pricepoints", "political", "public_key", "quotes", "relationship_status", "religion", "security_settings", "shared_login_upgrade_required_by", "significant_other", "sports", "test_group", "third_party_id", "timezone", "updated_time", "verified", "video_upload_limits", "viewer_can_send_gift", "website", "work", "accounts", "achievements", "ad_studies", "adaccounts", "adcontracts", "adnetworkanalytics", "albums", "apprequestformerrecipients", "apprequests", "books", "business_activities", "curated_collections", "domains", "events", "family", "favorite_requests", "fblite_to_nt_transitions", "friendlists", "friends", "games", "groups", "ids_for_business", "leadgen_forms", "likes", "live_videos", "movies", "music", "objects", "permissions", "personal_ad_accounts", "photos", "picture", "promotable_domains", "promotable_events", "request_history", "session_keys", "stream_filters", "taggable_friends", "tagged_places", "television", "video_broadcasts", "videos", "checkins", "feed", "home", "inbox", "locations", "mutualfriends", "notifications", "outbox", "questions", "scores", "subscribers", "subscribedto", "invitable_friends", "token_for_business"]
    
    private static let allReadPermissions = ["user_friends", "email", "user_about_me", "user_actions.books", "user_actions.fitness", "user_actions.music", "user_actions.news", "user_actions.video", "user_birthday", "user_education_history", "user_events", "user_games_activity", "user_hometown", "user_likes", "user_location", "user_managed_groups", "user_photos", "user_posts", "user_relationships", "user_relationship_details", "user_religion_politics", "user_tagged_places", "user_videos", "user_website", "user_work_history", "read_custom_friendlists", "read_insights", "read_audience_network_insights", "read_page_mailboxes", "pages_show_list", "ads_read", "pages_messaging", "pages_messaging_phone_number", "pages_messaging_subscriptions"]

    private static let publishOrManagePermissions = ["publish_pages", "manage_notifications", "publish_actions", "manage_pages", "pages_manage_cta", "pages_manage_instant_articles", "ads_management", "business_management"]
    
    static func loginButton() -> FBSDKLoginButton {
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = allReadPermissions
        return loginButton
    }
    
    static func startGraphRequestConnection(completionHandler: @escaping ([String: AnyObject]?, Error?) -> ()) {
        
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": selectedUserProperties.joined(separator: ",")])
        request!.start(completionHandler: {(connection, result, error) in
            completionHandler(result as? [String : AnyObject], error)
        })
    }
}
