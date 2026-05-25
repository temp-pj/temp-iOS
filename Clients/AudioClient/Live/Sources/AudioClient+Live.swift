//
//  AudioClient+Live.swift
//  ClientAudio
//
//  Created by 송지혁 on 5/2/26.
//

import ClientAudio
import Combine
import Models
import MusicKit

public enum AudioError: Error {
    case songNotFound
}

public extension AudioClient {
    
    static let live: AudioClient = {
        let player = ApplicationMusicPlayer.shared
        
        return AudioClient { id, start, end in
            var request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: MusicItemID(id))
            request.properties = [.albums]
            let response = try await request.response()
            
            let songs = response.items
            if songs.isEmpty { throw AudioError.songNotFound }
            guard let song = songs.first else { throw AudioError.songNotFound }
            
            let entry = MusicPlayer.Queue.Entry(song, startTime: start, endTime: end)
            player.queue = ApplicationMusicPlayer.Queue([entry])
            
            try await player.prepareToPlay()
            
        } play: {
            try await player.play()
            
        } stop: {
            player.stop()
        } playbackState: {
            
            return AsyncStream<PlaybackState> { continuation in
                let playbackStatePublisher = player.state.objectWillChange
                var cancellables = Set<AnyCancellable>()
                
                playbackStatePublisher
                    .sink { status in
                        let playbackState = player.state.playbackStatus
                        
                        switch playbackState {
                            case .playing:
                                continuation.yield(.playing)
                                
                            case .paused:
                                continuation.yield(.paused)
                                
                            case .interrupted:
                                continuation.yield(.interrupted)
                                
                            case .stopped:
                                continuation.yield(.stopped)
                                
                            default:
                                continuation.yield(.stopped)
                        }
                    }
                    .store(in: &cancellables)
            }
        }
    }()

}
