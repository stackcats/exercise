#include <gtk-3.0/gtk/gtk.h>

const gchar *first_name = "Alan";
const gchar *last_name = "Stackcats";

static void destroy(GtkWidget*, gpointer);
static void swap(GtkWidget*, GdkEventKey *, gpointer);
int main(int argc, char *argv[]) {
  gtk_init(&argc, &argv);

  GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  g_object_set(window, "title", first_name, NULL);
  g_object_set(window, "resizable", FALSE, NULL);
  g_object_set(window, "default-width", 300, NULL);
  g_object_set(window, "default-height", 100, NULL);

  g_signal_connect(G_OBJECT(window), "destroy", G_CALLBACK(destroy), NULL);

  GtkWidget *label = gtk_label_new(last_name);
  g_object_set(label, "selectable", TRUE, NULL);

  g_signal_connect(G_OBJECT(window), "key-press-event", G_CALLBACK(swap), (gpointer)label);
  
  gtk_container_add(GTK_CONTAINER(window), label);
  
  gtk_widget_show_all(window);
  
  gtk_main();
  
  return 0;
}

static void destroy(GtkWidget *widget, gpointer data) {
  gtk_main_quit();
}

static void swap(GtkWidget *widget, GdkEventKey *event, gpointer label) {
  g_message("swapped...");
  const gchar *title = NULL;
  g_object_get(widget, "title", &title, NULL);
  if (!g_ascii_strcasecmp(title, first_name)) {
    g_object_set(widget, "title", last_name, NULL);
    g_object_set(label, "label", first_name, NULL);
  } else {
    g_object_set(widget, "title", first_name, NULL);
    g_object_set(label, "label", last_name, NULL);
  }
}
