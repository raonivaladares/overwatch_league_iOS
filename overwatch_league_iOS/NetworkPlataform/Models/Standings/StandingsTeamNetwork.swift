struct StandingsTeamNetwork: Decodable {
    let id: Int
    let divisionId: Int
    let name: String
    let abbreviatedName: String
    let logo: Logo
    let colors: Colors
    let league: League
    let stages: Stages
    let preseason: Preseason
}
