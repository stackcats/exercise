#include <glib/gstdio.h>
#include <gtk/gtk.h>

typedef struct {
  GtkWidget *chooser, *entry, *button;
} Widgets;

static void file_change(GtkFileChooser *file_chooser, Widgets *w) {
  const gchar *filename = gtk_file_chooser_get_filename(file_chooser);
  int b = g_access(filename, W_OK);

  gtk_widget_set_sensitive(w->entry, !b);
  gtk_widget_set_sensitive(w->button, !b);
}

static void rename_file(GtkButton *button, Widgets *w) {
  const gchar *text = gtk_entry_get_text(GTK_ENTRY(w->entry));
  const gchar *old =
      gtk_file_chooser_get_filename(GTK_FILE_CHOOSER(w->chooser));
  const gchar *dirname = g_dirname(old);
  const gchar *new = g_strconcat(dirname, "/", text, NULL);

  g_rename(old, new);

  gtk_file_chooser_unselect_filename(GTK_FILE_CHOOSER(w->chooser), old);
  gtk_file_chooser_set_current_folder(GTK_FILE_CHOOSER(w->chooser), dirname);
  gtk_entry_set_text(GTK_ENTRY(w->entry), "");
  gtk_widget_set_sensitive(w->entry, FALSE);
  gtk_widget_set_sensitive(w->button, FALSE);
}

int main(int argc, char *argv[]) {
  gtk_init(&argc, &argv);

  Widgets *w = (Widgets *)g_malloc(sizeof(Widgets));

  GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_title(GTK_WINDOW(window), "4.1");
  gtk_container_set_border_width(GTK_CONTAINER(window), 10);
  gtk_widget_set_size_request(window, 250, 100);

  g_signal_connect(G_OBJECT(window), "destroy", G_CALLBACK(gtk_main_quit),
                   NULL);

  w->chooser = gtk_file_chooser_button_new("Chooser a File",
                                           GTK_FILE_CHOOSER_ACTION_OPEN);

  gtk_file_chooser_set_current_folder(GTK_FILE_CHOOSER(w->chooser),
                                      g_get_home_dir());

  GtkFileFilter *filter = gtk_file_filter_new();
  gtk_file_filter_add_pattern(filter, "*");
  gtk_file_filter_set_name(filter, "All Files");
  gtk_file_chooser_add_filter(GTK_FILE_CHOOSER(w->chooser), filter);

  w->entry = gtk_entry_new();
  gtk_widget_set_sensitive(w->entry, FALSE);

  w->button = gtk_button_new_with_label("Rename");
  gtk_widget_set_sensitive(w->button, FALSE);

  GtkWidget *box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 10);
  gtk_box_pack_start(GTK_BOX(box), w->chooser, FALSE, TRUE, 5);
  gtk_box_pack_start(GTK_BOX(box), w->entry, FALSE, TRUE, 5);
  gtk_box_pack_start(GTK_BOX(box), w->button, FALSE, TRUE, 5);

  gtk_container_add(GTK_CONTAINER(window), box);

  g_signal_connect(G_OBJECT(w->chooser), "selection_changed",
                   G_CALLBACK(file_change), (gpointer)w);

  g_signal_connect(G_OBJECT(w->button), "clicked", G_CALLBACK(rename_file),
                   (gpointer)w);

  gtk_widget_show_all(window);

  gtk_main();

  return 0;
}
