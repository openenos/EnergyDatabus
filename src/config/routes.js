/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      app routes
 !**/
 
"use strict";

module.exports = {
    '/user/signup': {
        post: {
            controller: "UserController",
            method: "signup",
            public: true
        }
    }, 
    '/user/signin': {
        post: {
            controller: "UserController",
            method: "signin",
            public: true
        }
    }, 
    '/Channel/create': {
        post: {
            controller: "ChannelController",
            method: "create",
            public: true
        }
    }, 
    '/loadtype/create': {
        post: {
            controller: "ElecLoadTypeController",
            method: "create",
            public: true
        }
    }, 
    '/group/create': {
        post: {
            controller: "GroupController",
            method: "create",
            public: true
        }
    }, 
    '/location/create': {
        post: {
            controller: "LocationController",
            method: "create",
            public: true
        }
    }, 
    '/panel/create': {
        post: {
            controller: "PanelController",
            method: "create",
            public: true
        }
    }, 
    '/postal/create': {
        post: {
            controller: "PostalInfoController",
            method: "create",
            public: true
        }
    }, 
    '/site/create': {
        post: {
            controller: "SiteController",
            method: "create",
            public: true
        }
    }, 
    '/utility/create': {
        post: {
            controller: "UtilityController",
            method: "create",
            public: true
        }
    }, 
    '/test': {
        post: {
            controller: "HomeController",
            method: "login",
            public: true
        }
    }, 
    '/group/power_usage': {
        get: {
            controller: "GroupController",
            method: "getPowerUsage",
            public: true
        }
    },
    '/group/past_power_usage': {
        get: {
            controller: "GroupController",
            method: "getPast30DaysUsage",
            public: true
        }
    },
    '/group/past_months_usage': {
        get: {
            controller: "GroupController",
            method: "getLast12MonthsData",
            public: true
        }
    },
    '/group/past_days_usage': {
        get: {
            controller: "GroupController",
            method: "getPastDaysUsage",
            public: true
        }
    },
    '/group/index': {
        get: {
            controller: "GroupController",
            method: "getAllGroups",
            public: true
        }
    },
    '/channel/all': {
        get: {
            controller: "ChannelController",
            method: "getAllChannels",
            public: true
        }
    },
    '/channel/current_demand': {
        get: {
            controller: "ChannelController",
            method: "getCurrentDemand",
            public: true
        }
    },
    '/channel/month': {
        get: {
            controller: "ChannelController",
            method: "getMonthValue",
            public: true
        }
    },
    '/channel/report': {
        get: {
            controller: "ChannelController",
            method: "getDayWeekMonthYearJsonReport",
            public: true
        }
    },
    '/site/live': {
        get: {
            controller: "SiteController",
            method: "getLiveData",
            public: true
        }
    },
    '/site/solar': {
        get: {
            controller: "SiteController",
            method: "getSolarData",
            public: true
        }
    },
    '/site/current_demand': {
        get: {
            controller: "SiteController",
            method: "getCurrentDemand",
            public: true
        }
    },
    '/site/hour': {
        get: {
            controller: "SiteController",
            method: "getLastHoursData",
            public: true
        }
    },
    '/site/five': {
        get: {
            controller: "SiteController",
            method: "getLastFive",
            public: true
        }
    },
    '/site/weather': {
        get: {
            controller: "SiteController",
            method: "getweatherReport",
            public: true
        }
    },
    '/appliances': {
        get: {
            controller: "AppliancesController",
            method: "getAllChannelsData",
            public: true
        }
    }
};
