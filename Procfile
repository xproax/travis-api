<script src="https://d3tvtfb6518e3e.cloudfront.net/3/opbeat.min.js"
    data-org-id="99fadbe179644906a91f3f6643357dd8"
    data-app-id="9efcf1fb48">
</script>
                                 
npm install opbeat-js --save

<script src="node_modules/opbeat-js/opbeat.min.js"></script>

web: ./script/server
console: bundle exec je ./script/console
sidekiq: bundle exec je sidekiq -c 4 -r ./lib/travis/sidekiq.rb -q build_cancellations, -q build_restarts, -q job_cancellations, -q job_restarts
cron: bin/cron
