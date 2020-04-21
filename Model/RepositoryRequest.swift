import Foundation

enum RepositoryError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct RepositroyRequest {
    let resourceURL: URL
    
    init(searchString: String) {

        let resourceString = "https://api.github.com/search/repositories?q=\(searchString)"

        guard let resourceURL = URL(string: resourceString) else { fatalError() }

        self.resourceURL = resourceURL
    }

    func getRepositories(completion: @escaping(Result<[RepositoryDetail], RepositoryError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in  
            guard let jsonData = data else { 
                completion(.failure(.noDataAvailable))
                return
             }
             do {
                 let decoder = JSONDecoder()
                 let repositoriesResponse = try decoder.decode(Repository.self, from: jsonData)
                 let repositoryDetails = repositoriesResponse.response.repositories
                 let sortRepositoryDetails = repositoryDetails.sort({$0.updated_at.timeIntervalSinceNow > $1.updated_at.timeIntervalSinceNow})
                 completion(.success(sortRepositoryDetails))
             } catch {
                 completion(.failure(.canNotProcessData))
             }
        }
        dataTask.resume()
    }

}