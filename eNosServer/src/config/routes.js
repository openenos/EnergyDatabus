"use strict";

module.exports = {
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
