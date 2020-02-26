package net.sounds.app.sounds_app;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.media.Rating;
import android.media.session.MediaController;
import android.media.session.MediaSession;
import android.os.Build;
import android.os.IBinder;
import android.support.annotation.Nullable;
import android.util.Log;
import io.flutter.plugin.common.MethodChannel;

public class MediaPlayerService extends Service {

    public static final String ACTION_PLAY = "action_play";
    public static final String ACTION_PAUSE = "action_pause";
    public static final String ACTION_STOP = "action_stop";

    private MediaSession mSession;
    private MediaController mController;

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    private void handleIntent(Intent intent) {
        if (intent == null || intent.getAction() == null)
            return;

        String action = intent.getAction();

        if (action.equalsIgnoreCase(ACTION_PLAY)) {
            mController.getTransportControls().play();
        } else if (action.equalsIgnoreCase(ACTION_PAUSE)) {
            mController.getTransportControls().pause();
        } else if (action.equalsIgnoreCase(ACTION_STOP)) {
            mController.getTransportControls().stop();
        }
    }

    private Notification.Action generateAction(int icon, String title, String intentAction) {
        Intent intent = new Intent(getApplicationContext(), MediaPlayerService.class);
        intent.setAction(intentAction);
        PendingIntent pendingIntent = PendingIntent.getService(getApplicationContext(), 199, intent, 0);
        return new Notification.Action.Builder(icon, title, pendingIntent).build();
    }

    private void buildNotification(Notification.Action action) {

        Notification.MediaStyle style = new Notification.MediaStyle().setShowActionsInCompactView(0);

        Notification.Builder builder;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            int importance = NotificationManager.IMPORTANCE_HIGH;
            NotificationChannel notificationChannel = new NotificationChannel("MusicService", "MusicService", importance);

            NotificationManager notificationManager = (NotificationManager) this.getSystemService(Context.NOTIFICATION_SERVICE);
            notificationManager.createNotificationChannel(notificationChannel);

            builder = new Notification.Builder(this, "MusicService")
                    .setSmallIcon(R.drawable.crown)
                    .setContentTitle("Sound app")
                    .setContentText("Playing sound")
                    .setVisibility(Notification.VISIBILITY_PUBLIC)
                    .setStyle(style);
        } else {
            builder = new Notification.Builder(this)
                    .setSmallIcon(R.drawable.crown)
                    .setContentTitle("Sound app")
                    .setContentText("Playing sound")
                    .setPriority(Notification.PRIORITY_MAX)
                    .setVisibility(Notification.VISIBILITY_PUBLIC)
                    .setStyle(style);
        }


        builder.addAction(action);
        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.cancelAll();
        notificationManager.notify(1, builder.build());

    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        initMediaSessions();
        handleIntent(intent);
        return super.onStartCommand(intent, flags, startId);
    }

    private void initMediaSessions() {

        mSession = new MediaSession(getApplicationContext(), "simple player session");
        mController = new MediaController(getApplicationContext(), mSession.getSessionToken());

        mSession.setCallback(new MediaSession.Callback() {
                                 @Override
                                 public void onPlay() {
                                     super.onPlay();
                                     Log.e("MediaPlayerService", "onPlay");
                                     try {
                                         MainActivity.channel.invokeMethod("play", "play", new MethodChannel.Result(){
                                             @Override
                                             public void success(@Nullable Object o) {
                                                 System.out.println("play OK");
                                             }

                                             @Override
                                             public void error(String s, @Nullable String s1, @Nullable Object o) {
                                                 System.out.println("play error");
                                             }

                                             @Override
                                             public void notImplemented() {
                                                 System.out.println("play not implementerd");
                                             }
                                         });
                                         buildNotification(generateAction(R.drawable.play, "Pause", ACTION_PAUSE));
                                     } catch (Exception e){e.printStackTrace();
                                         NotificationManager notificationManager = (NotificationManager) getApplicationContext().getSystemService(Context.NOTIFICATION_SERVICE);
                                         notificationManager.cancelAll();;}


                                 }

                                 @Override
                                 public void onPause() {
                                     super.onPause();
                                     Log.e("MediaPlayerService", "onPause");
                                     try {
                                         MainActivity.channel.invokeMethod("stop", "stop", new MethodChannel.Result() {
                                             @Override
                                             public void success(@Nullable Object o) {
                                                 System.out.println("stop OK");
                                             }

                                             @Override
                                             public void error(String s, @Nullable String s1, @Nullable Object o) {
                                                 System.out.println("stop error");
                                             }

                                             @Override
                                             public void notImplemented() {
                                                 System.out.println("stop not implementerd");
                                             }
                                         });


                                         buildNotification(generateAction(R.drawable.pause, "Play", ACTION_PLAY));
                                     } catch (Exception e){e.printStackTrace();
                                         NotificationManager notificationManager = (NotificationManager) getApplicationContext().getSystemService(Context.NOTIFICATION_SERVICE);
                                         notificationManager.cancel(1);}

                                 }

                                 @Override
                                 public void onSkipToNext() {
                                     super.onSkipToNext();
                                     Log.e("MediaPlayerService", "onSkipToNext");
                                 }

                                 @Override
                                 public void onSkipToPrevious() {
                                     super.onSkipToPrevious();
                                     Log.e("MediaPlayerService", "onSkipToPrevious");
                                 }

                                 @Override
                                 public void onFastForward() {
                                     super.onFastForward();
                                     Log.e("MediaPlayerService", "onFastForward");
                                 }

                                 @Override
                                 public void onRewind() {
                                     super.onRewind();
                                     Log.e("MediaPlayerService", "onRewind");
                                 }

                                 @Override
                                 public void onStop() {
                                     super.onStop();
                                     Log.e("MediaPlayerService", "onStop");
                                     NotificationManager notificationManager = (NotificationManager) getApplicationContext().getSystemService(Context.NOTIFICATION_SERVICE);
                                     notificationManager.cancel(1);
                                     Intent intent = new Intent(getApplicationContext(), MediaPlayerService.class);
                                     stopService(intent);
                                 }

                                 @Override
                                 public void onSeekTo(long pos) {
                                     super.onSeekTo(pos);
                                 }

                                 @Override
                                 public void onSetRating(Rating rating) {
                                     super.onSetRating(rating);
                                 }
                             }
        );
    }

    @Override
    public boolean onUnbind(Intent intent) {
        mSession.release();
        return super.onUnbind(intent);
    }
}

