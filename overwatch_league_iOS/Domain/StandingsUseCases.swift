import Foundation
import Combine

final class StandsUseCases {
    private let standingsWebService: StandingsWebService
    
    init(standingsWebService: StandingsWebService) {
        self.standingsWebService = standingsWebService
    }
    
    func getStandings() -> AnyPublisher<[StandingsTeamDomain], DomainError> {
            standingsWebService.fetchStandings()
            .map { $0.data.map(self.domainConverter) }
            .mapError(domainErrorConverter)
            .eraseToAnyPublisher()
    }
    
    private func domainConverter(modelNetwork: StandingsTeamNetwork) -> StandingsTeamDomain {
        .init()
    }
    
    private func domainErrorConverter(networkError: NetworkPlataformError) -> DomainError {
        .domainUnknown
    }
}

struct StandingsTeamDomain {
    
}

enum DomainError: Error {
    case domainUnknown
}
