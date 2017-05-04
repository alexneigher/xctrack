desc 'import xcfind paragliders for the league'
task xc_league: :environment do
   pilots = [
              {
                name: 'Chris Cote',
                spot_share_url: '0OQC2EvSbXKVozJGR0Sg7vE8HYfvzdyps',
                tracker_type: 1
              },
              {
                name: 'Scott Harding',
                in_reach_share_url: 'ScottHarding',
                tracker_type: 0
              },
              {
                name: 'Tom Mook',
                spot_share_url: '02N8mb2RiXf62S7EqFmjHN6oSE48zhmlN',
                tracker_type: 1
              },
              {
                name: 'Vitali Umanskyi',
                in_reach_share_url: 'VitalyU',
                tracker_type: 0
              },
              {
                name: 'Steve Young',
                in_reach_share_url: 'StevenYoung',
                tracker_type: 0
              },
              {
                name: 'Schuyler Heath',
                in_reach_share_url: 'Sky',
                tracker_type: 0
              },
              {
                name: 'David McMillan',
                in_reach_share_url: 'davidmcmillan',
                tracker_type: 0
              },
              {
                name: 'Fabian Perez',
                in_reach_share_url: 'FabianPerez1535',
                tracker_type: 0
              },
              {
                name: 'Jay Gordon',
                in_reach_share_url: 'JayGordon',
                tracker_type: 0
              },
              {
                name: 'Scott MacLeod',
                in_reach_share_url: 'ScottMacLeod',
                tracker_type: 0
              },
              {
                name: 'Jared Anderson',
                in_reach_share_url: 'JaredAnderson',
                tracker_type: 0
              },
              {
                name: 'Darren Payne',
                spot_share_url: '0ez0f8dMhMM8QqQnkg2BYRCl3dn3uoRYI',
                tracker_type: 1
              },
              {
                name: 'Mark Stump',
                spot_share_url: '0ZBx57D8SdZJF95ANsxgAvB45ad2DaRHp',
                tracker_type: 1
              },
              {
                name: 'Michal Hammel',
                spot_share_url: '0RrhrnxcxuERrPyvcjIW4bYPCSVbdDFfI',
                tracker_type: 1
              },
              {
                name: 'Neal Michaelis',
                spot_share_url: '0IBKYrP9bbVlqQfMRqVh74cejh7jfQQyk',
                tracker_type: 1
              },
              {
                name: 'Kirsten Seeto',
                in_reach_share_url: 'Kirsten',
                tracker_type: 0
              },
              {
                name: 'Sean Zornes',
                in_reach_share_url: 'seanzornes',
                tracker_type: 0
              },
              {
                name: 'Greg Didriksen',
                in_reach_share_url: 'GregDidriksen',
                tracker_type: 0
              },
              {
                name: 'Harry Sandoval',
                in_reach_share_url: 'HarrySandoval',
                tracker_type: 0
              },
              {
                name: 'Ron Andresen',
                in_reach_share_url: 'RonAndresen',
                tracker_type: 0
              },
              {
                name: 'Roland Martin',
                spot_share_url: '08l3kt8tqUhqc01xYmg5TsdRJPpndBcHu',
                tracker_type: 1
              },
              {
                name: 'Pavlo Rudakevych',
                spot_share_url: '0l9opUzTK6GhTHVmXe41SY6lluCRAXdd9',
                tracker_type: 1
              },
              {
                name: 'Debbie Vosevich',
                in_reach_share_url: 'DebbieVosevich',
                tracker_type: 0
              },
              {
                name: 'Brad Bass',
                spot_share_url: '0frTepgYM6oA1SZq8JQDgMzgPEyq0uco4',
                tracker_type: 1
              },
              {
                name: 'Jugdeep Aggarwal',
                in_reach_share_url: 'Jug',
                tracker_type: 0
              },
              {
                name: 'Eric Ams',
                spot_share_url: '0WoqzmO6XmGqc3YPNGXyIvAObTl3PFxls',
                tracker_type: 1
              },
              {
                name: 'Patrick Allaire',
                in_reach_share_url: 'PatrickAllaire',
                tracker_type: 0
              },
              {
                name: 'David Prevost',
                spot_share_url: '0MerQCUH2Fgay9LdukuIcy294XFoqefjl',
                tracker_type: 1
              },
              {
                name: 'Brian Thibeault',
                in_reach_share_url: 'BrianThibeault',
                tracker_type: 0
              },
              {
                name: 'Robin Cushman',
                in_reach_share_url: 'RobinCushman',
                tracker_type: 0
              },
              {
                name: 'Scott Hooper',
                spot_share_url: '064ic8q36ICYAGCv68TH0VNmS16BkRGEO',
                tracker_type: 1
              },
            ]

  puts "creating #{pilots.count} users"
  users_count = 0

  group = Group.find_by_name('NCXC')

  pilots.each do |pilot|
    
    puts "creating #{pilot[:name]}"
    user = User.create(
      in_reach_share_url: pilot[:in_reach_share_url],
      spot_share_url: pilot[:spot_share_url],
      email: "#{pilot[:name].downcase.gsub(/\s/, '_')}@gmail.com",
      password: '1234567890',
      name: pilot[:name],
      tracker_type: pilot[:tracker_type]
    )
    
    
    if user.valid?
      users_count += 1
      UserGrouping.create(group_id: group.id, user_id: user.id)
    end

  end

  puts users_count

end